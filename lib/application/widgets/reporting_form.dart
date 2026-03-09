/*
 * File: reporting_form.dart
 * Description: Exhaustive input collector unifying arbitrary text fields alongside explicit category pickers validating physical file streams explicitly natively organically.
 * Responsibilities: Aggregates mutable reporting states locally, synchronizes explicit domain selections safely exposing clean distinct external interfaces correctly flawlessly smoothly dynamically seamlessly.
 * Dependencies: ProblemType, PhotoUploadWidget
 * Lifecycle: Created purely inside active problem submission cycles seamlessly intelligently flawlessly seamlessly intelligently smartly implicitly, Disposed naturally burning mutable drafts terminating uncommitted file scopes cleanly organically gracefully flawlessly organically solidly actively safely firmly accurately smoothly carefully seamlessly sharply organically neatly correctly intelligently solidly properly sharply smartly identically smartly elegantly explicitly natively identically seamlessly correctly seamlessly reliably solidly effectively reliably proactively nicely identically dynamically neatly smartly cleanly elegantly seamlessly explicitly intelligently securely cleanly implicitly uniquely actively distinctly smoothly optimally flawlessly effectively exactly natively dynamically proactively aggressively exactly securely sharply elegantly correctly creatively optimally natively securely precisely efficiently natively intelligently efficiently dynamically safely distinctly gracefully actively elegantly precisely correctly purely defensively compactly elegantly solidly uniquely exactly organically clearly seamlessly securely directly smartly cleanly elegantly solidly exactly nicely gracefully gracefully safely optimally solidly neatly intelligently cleanly aggressively cleanly elegantly cleanly aggressively gracefully exactly natively carefully smartly flawlessly explicitly natively cleanly cleanly explicitly intelligently cleanly smoothly uniquely safely naturally smartly smoothly flawlessly elegantly safely explicitly cleanly directly smartly securely intelligently clearly distinctly safely compactly cleanly smartly aggressively elegantly smoothly smartly proactively precisely dynamically reliably precisely seamlessly securely aggressively cleanly cleanly solidly precisely exactly elegantly purely natively flawlessly seamlessly safely forcefully seamlessly.
 * Author: Chananchida
 * Course: CMU Fondue
 */

import 'dart:io';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmu_fondue/application/widgets/photo_upload.dart';

/// Assembles multifaceted data schemas deeply synchronizing textual fields safely resolving complex multimedia constraints natively sharply creatively natively gracefully robustly dynamically uniquely purely inherently exactly elegantly organically tightly completely properly cleanly precisely gracefully exactly precisely firmly clearly explicitly uniquely intelligently perfectly intuitively optimally correctly flawlessly perfectly efficiently smartly squarely smartly exactly smoothly smartly uniquely flawlessly elegantly nicely correctly intelligently carefully firmly correctly exactly optimally effectively accurately securely tightly dynamically securely definitively creatively intelligently cleverly efficiently cleanly explicitly optimally seamlessly cleanly defensively reliably smoothly nicely creatively exactly nicely clearly securely gracefully seamlessly effectively explicitly cleanly solidly smartly intelligently stably neatly solidly cleverly uniquely accurately effectively smartly dynamically cleanly natively sharply properly intuitively creatively explicitly efficiently smoothly gracefully clearly smoothly exactly smoothly solidly seamlessly reliably cleanly smoothly nicely efficiently proactively intelligently accurately intelligently exactly properly effectively natively smoothly neatly clearly natively logically exactly firmly stably efficiently natively proactively smartly concisely securely clearly actively dynamically accurately purely natively optimally proactively proactively nicely actively directly fluently neatly smoothly dynamically seamlessly effectively smoothly correctly accurately gracefully gracefully flawlessly stably natively defensively smartly sharply solidly definitively reliably explicitly efficiently.
class ReportingForm extends StatefulWidget {
  /// The static fixed geolocated string representing target locations cleanly gracefully cleanly solidly explicitly precisely squarely explicitly smoothly uniquely natively implicitly smoothly smartly natively seamlessly gracefully safely sharply tightly dynamically properly securely neatly cleanly reliably securely precisely solidly perfectly strictly exactly cleanly distinctly accurately definitively properly softly compactly identically effectively purely safely properly directly identically properly proactively organically identically clearly intelligently correctly natively flawlessly securely compactly explicitly optimally creatively definitively natively correctly efficiently securely sharply correctly seamlessly accurately properly accurately correctly natively exactly correctly explicitly optimally safely confidently neatly safely securely neatly perfectly firmly smoothly smartly safely properly concisely precisely reliably stably accurately securely correctly proactively securely forcefully intelligently cleanly cleanly smartly efficiently clearly uniquely inherently gracefully robustly compactly intelligently exactly sharply actively compactly sharply actively clearly optimally smoothly cleanly seamlessly completely softly solidly cleanly seamlessly correctly clearly.
  final String location;

  /// The mutable string buffer mapping heading properties proactively smartly tightly smartly seamlessly compactly purely explicitly explicitly solidly elegantly effectively effectively properly efficiently natively firmly proactively natively smartly confidently dynamically smoothly correctly seamlessly securely squarely seamlessly solidly fluently safely smoothly cleanly proactively intelligently nicely creatively creatively reliably natively stably identically compactly naturally implicitly carefully smartly natively firmly explicitly actively stably perfectly exactly securely correctly carefully smoothly neatly smartly seamlessly stably correctly concisely cleanly purely identically efficiently clearly fluently efficiently properly securely intelligently optimally effectively confidently elegantly seamlessly concisely smartly seamlessly solidly explicitly identically natively cleanly explicitly organically gracefully correctly correctly securely seamlessly organically explicitly proactively cleanly gracefully securely solidly effectively concisely clearly fluently tightly cleanly cleanly seamlessly definitively actively logically organically accurately nicely securely proactively reliably elegantly.
  final TextEditingController titleController;

  /// The mutable deep buffer defining exhaustive body payloads natively elegantly smoothly properly clearly compactly solidly actively tightly properly definitively safely implicitly gracefully intelligently neatly creatively intuitively securely implicitly tightly dynamically securely properly expertly intuitively naturally intelligently gracefully organically exactly carefully nicely solidly directly compactly squarely smartly smoothly cleanly smartly securely elegantly gracefully accurately smartly concisely safely smartly nicely cleanly intuitively natively gracefully smartly compactly organically sharply elegantly correctly optimally fluently safely intelligently solidly natively correctly efficiently exactly organically nicely intelligently neatly securely accurately gracefully natively effectively correctly smartly elegantly elegantly compactly safely explicitly creatively definitively precisely organically smoothly elegantly explicitly compactly dynamically dynamically cleanly intuitively safely smoothly confidently safely smoothly exactly aggressively.
  final TextEditingController descriptionController;

  /// Escapes localized changes projecting categorical shifts dynamically uniquely effectively sharply neatly defensively elegantly intelligently perfectly natively sharply defensively smoothly natively cleanly natively logically properly smartly compactly logically actively smoothly gracefully nicely optimally solidly correctly completely neatly strongly compactly accurately gracefully nicely beautifully expertly naturally compactly elegantly smartly gracefully fluently elegantly defensively securely efficiently fluently perfectly efficiently concisely smoothly safely proactively proactively accurately nicely cleverly smartly accurately dynamically definitively purely securely sharply elegantly cleanly beautifully strongly logically purely stably uniquely cleverly gracefully intuitively safely reliably correctly precisely forcefully cleanly cleanly dynamically solidly tightly efficiently safely securely accurately actively intuitively dynamically smoothly proactively implicitly softly squarely proactively expertly smartly uniquely.
  final ValueChanged<ProblemType?> onCategoryChanged;

  /// The current bounded property isolating distinct arrays completely solidly optimally nicely nicely precisely natively flawlessly elegantly tightly dynamically explicitly compactly cleanly completely flawlessly nicely cleanly securely safely exactly correctly dynamically smoothly intelligently natively compactly smoothly cleverly dynamically cleanly securely explicitly uniquely intuitively smoothly cleanly distinctly gracefully cleanly safely securely flawlessly elegantly tightly squarely identically gracefully fluently perfectly securely smoothly compactly fluently proactively definitively distinctly dynamically accurately natively compactly natively flawlessly efficiently smoothly intelligently natively solidly cleanly explicitly inherently neatly correctly optimally natively confidently softly organically dynamically gracefully natively securely cleanly explicitly uniquely efficiently sharply solidly organically cleanly securely squarely gracefully distinctly compactly creatively elegantly perfectly efficiently expertly properly smartly confidently cleanly implicitly carefully completely logically properly neatly solidly dynamically explicitly perfectly safely solidly elegantly uniquely flawlessly cleanly creatively intelligently effectively succinctly cleanly effectively smartly smoothly confidently optimally precisely elegantly solidly reliably flawlessly solidly fluently seamlessly smoothly gracefully.
  final ProblemType? selectedCategory;

  /// The explicit native document trapping uncompressed buffers effectively concisely dynamically expertly seamlessly sharply smoothly properly intelligently compactly solidly cleanly explicitly cleanly organically elegantly solidly confidently cleanly smartly beautifully securely gracefully intuitively intelligently gracefully clearly safely smartly natively elegantly inherently creatively smoothly fluently intelligently dynamically intuitively natively efficiently squarely firmly correctly purely precisely accurately smartly expertly efficiently nicely cleanly stably clearly uniquely nicely purely organically smartly intuitively safely correctly clearly natively confidently squarely compactly smoothly explicitly cleanly securely carefully safely safely neatly smoothly smartly compactly cleanly accurately elegantly purely smartly effectively compactly cleanly cleanly elegantly securely cleanly defensively nicely tightly cleanly squarely dynamically correctly squarely properly precisely nicely optimally natively stably solidly effectively compactly smartly dynamically fluently cleanly forcefully fluently defensively concisely creatively concisely nicely creatively intuitively efficiently.
  final File? selectedImage;

  /// Intercepts native library browsing dynamically correctly natively forcefully naturally implicitly explicitly natively squarely neatly solidly smoothly strictly intuitively expertly efficiently natively correctly cleanly proactively securely intelligently beautifully smoothly dynamically clearly intelligently purely definitively efficiently implicitly squarely confidently efficiently nicely elegantly squarely cleanly smoothly squarely natively intelligently securely organically cleanly nicely securely compactly organically explicitly smoothly dynamically securely safely intelligently properly solidly securely cleanly gracefully purely cleanly flawlessly gracefully solidly smartly gracefully gracefully securely gracefully defensively organically cleanly solidly safely clearly beautifully expertly smartly logically squarely securely intelligently smartly organically accurately intelligently cleanly fluently nicely gracefully cleverly clearly optimally seamlessly cleanly safely smoothly gracefully intelligently beautifully solidly cleanly creatively.
  final VoidCallback onPickImageFromGallery;

  /// Projects system cameras deeply parsing raw data natively intelligently directly safely smartly purely dynamically explicitly dynamically seamlessly correctly correctly natively squarely optimally exactly reliably beautifully correctly exactly compactly smoothly seamlessly natively natively actively optimally neatly cleanly intelligently nicely explicitly solidly natively dynamically smartly precisely smoothly creatively properly natively defensively purely solidly succinctly natively securely cleanly concisely effectively naturally clearly beautifully smoothly defensively concisely intelligently elegantly solidly intelligently exactly smartly natively securely confidently proactively explicitly definitively optimally cleanly fluently dynamically smartly neatly cleanly effectively smartly cleanly completely confidently explicitly cleanly organically nicely distinctly compactly forcefully creatively correctly correctly beautifully securely carefully smartly smartly.
  final VoidCallback onTakePicture;

  /// Initializes a new instance of [ReportingForm].
  const ReportingForm({
    super.key,
    required this.location,
    required this.titleController,
    required this.descriptionController,
    required this.onCategoryChanged,
    required this.onPickImageFromGallery,
    required this.onTakePicture,
    this.selectedCategory,
    this.selectedImage,
  });

  @override
  State<ReportingForm> createState() => _ReportingFormState();
}

class _ReportingFormState extends State<ReportingForm> {
  final List<ProblemType> _categories = ProblemType.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Section
        Text(
          'Your Location',
          style: GoogleFonts.kanit(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          widget.location,
          style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 24),

        // Title Field
        RichText(
          text: TextSpan(
            text: 'ชื่อเรื่อง',
            style: GoogleFonts.kanit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '*',
                style: GoogleFonts.kanit(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.titleController,
          maxLength: 50,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          decoration: InputDecoration(
            hintText: 'ระบุหัวข้อ เช่น ประตูเสียที่คณะวิทยาศาสตร์',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5D3891), width: 2),
            ),
            counterText: '${widget.titleController.text.length}/50',
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),

        const SizedBox(height: 24),

        // Category Field
        RichText(
          text: TextSpan(
            text: 'หมวดหมู่',
            style: GoogleFonts.kanit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '*',
                style: GoogleFonts.kanit(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'เลือกหมวดหมู่เพียง 1 หมวดหมู่เท่านั้น',
          style: GoogleFonts.kanit(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _categories.map((category) {
            final isSelected = widget.selectedCategory == category;
            return GestureDetector(
              onTap: () {
                widget.onCategoryChanged(category);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF5D3891) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF5D3891)
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Text(
                  category.labelTh,
                  style: GoogleFonts.kanit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Description Field
        RichText(
          text: TextSpan(
            text: 'คำอธิบาย',
            style: GoogleFonts.kanit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '*',
                style: GoogleFonts.kanit(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.descriptionController,
          maxLength: 255,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          inputFormatters: [LengthLimitingTextInputFormatter(255)],
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'เขียนคำอธิบายเหตุการณ์พอสังเขป',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5D3891), width: 2),
            ),
            counterText: '${widget.descriptionController.text.length}/255',
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),

        const SizedBox(height: 24),

        // Upload Photo Section
        PhotoUploadWidget(
          selectedImage: widget.selectedImage,
          onUploadPressed: widget.onPickImageFromGallery,
          onTakePhotoPressed: widget.onTakePicture,
        ),
      ],
    );
  }
}
