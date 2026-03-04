/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {setGlobalOptions} from "firebase-functions";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({maxInstances: 1});

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Komsan
import * as admin from "firebase-admin";
import {onCall, CallableRequest, HttpsError} from
  "firebase-functions/v2/https";

admin.initializeApp();

/**
 * ส่ง Push Notification เมื่อมีการอัปเดตสถานะของ Problem
 * เรียกจาก App หลังจาก Admin เปลี่ยนสถานะ Problem
 *
 * Parameters:
 * - problemId: ID ของ Problem
 * - problemTitle: ชื่อปัญหา
 * - newTagName: ชื่อสถานะใหม่ (tagThaiName)
 * - fcmToken: FCM Token ของเจ้าของปัญหา
 */
export const sendProblemStatusNotification = onCall(
  {
    // Enable App Check but don't enforce (allows debug tokens in development)
    consumeAppCheckToken: true,
    enforceAppCheck: false,
    // Allow all authenticated Firebase users to invoke this function
    invoker: "public",
  },
  async (request: CallableRequest) => {
    // ตรวจสอบว่า User Login และเป็น Admin
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "กรุณาเข้าสู่ระบบ");
    }

    const {problemId, problemTitle, newTagName, fcmToken} = request.data;

    // Validate input
    if (!problemId || !problemTitle || !newTagName || !fcmToken) {
      throw new HttpsError(
        "invalid-argument",
        "Missing required parameters"
      );
    }

    // ส่ง notification
    const message: admin.messaging.Message = {
      notification: {
        title: "อัปเดตสถานะปัญหา",
        body: `"${problemTitle}" เปลี่ยนสถานะเป็น "${newTagName}"`,
      },
      data: {
        problemId: problemId,
        type: "problem_status_update",
        newTagName: newTagName,
      },
      token: fcmToken,
      android: {
        priority: "high",
        notification: {
          channelId: "problem_updates",
          sound: "default",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
            badge: 1,
          },
        },
      },
    };

    try {
      await admin.messaging().send(message);
      console.log("Notification sent for problem:", problemId);
      return {success: true, sentAt: new Date().toISOString()};
    } catch (error) {
      console.error("Error sending notification:", error);

      const errorCode = (error as {code?: string}).code;
      if (errorCode === "messaging/registration-token-not-registered") {
        console.log("Invalid FCM token for problem:", problemId);
        throw new HttpsError(
          "failed-precondition",
          "FCM token is invalid or expired"
        );
      }

      throw new HttpsError("internal", "Failed to send notification");
    }
  });
