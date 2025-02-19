import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnt_app/data/model/course.dart';
import 'package:learnt_app/data/model/section.dart';
import 'package:learnt_app/data/model/student.dart';
import 'package:learnt_app/helper/class/local_storge.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'learnt_state.dart';

enum Status {
  pending(2),
  removed(0),
  completed(1);

  final int code;
  const Status(this.code); // Constructor to assign integer values
}

class LearntCubit extends Cubit<LearntState> {
  LearntCubit() : super(LearntInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  bool isGroupBox = false;
  bool isOnlyBox = false;
  bool isRealBox = false;
  bool isOnlineBox = false;
  final ImagePicker picker = ImagePicker();
  final supabase = Supabase.instance.client;
  int x = 0;
  String sectionName = '';
  String subject = '';
  final List<Section> sections = [];
  final List<Course> coursesBySection = [];

  String typeOfStudy() {
    return isGroupBox ? 'مجموعة' : 'شخصي';
  }

  String locationStudy() {
    return isOnlineBox ? 'على الانترنت' : 'حضور';
  }

  void setSRegister(String subject, String section) {
    this.subject = subject;
    sectionName = section;
    LocalStorge.setValue('subject', this.subject);
    LocalStorge.setValue('section', sectionName);
    emit(LearntInitial(section: sectionName, subject: this.subject));
  }

  String getSubject() {
    return LocalStorge.getValue('subject');
  }

  String getSection() {
    return LocalStorge.getValue('section');
  }

  String getSectionCourse() {
    return LocalStorge.getValue('sectionCourse');
  }

  Future<List<Section>> fetchSections() async {
    try {
      emit(LearntLoading());
      final response = await supabase.from('section').select();
      final sectios = response.map((e) => Section.fromJson(e)).toList();
      log('Fetch operation completed.');
      emit(LearntLoadSectionSuccess(sectios));
      sections.addAll(sectios);
      return sectios;
    } catch (e) {
      log("❌ Error fetching section: $e");
      emit(LearntLoadSectionFailure(e.toString()));
      rethrow;
    }
  }

  Future<List<Course>> fetchAllCourses({String? section}) async {
    try {
      LocalStorge.setValue('sectionCourse', section.toString());
      emit(LearntLoading());

      if (section != null) {
        var response =
            await supabase.from('course').select().eq('sectionName', section);
        final courses = (response as List<dynamic>)
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList();

        log('Fetch operation completed. done');

        emit(LearntLoadCourseSuccess(courses));

        coursesBySection.addAll(courses);

        return courses;
      } else {
        log(coursesBySection.length.toString());
        emit(LearntLoadCourseSuccess(coursesBySection));
        return coursesBySection;
      }
    } catch (e) {
      log("❌ Error fetching courses: $e");
      emit(LearntLoadCourseFailure(e.toString()));
      rethrow;
    }
  }

  void getSectionName(Section section) {
    sectionName = section.name;
  }

  Student convertToStudent({String? subject, String? section}) {
    return Student(
      name: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      typeOfStudy: typeOfStudy(),
      dateOfBirth: dateController.text.toString(),
      address: addressController.text,
      subject: subject ?? 'بدون موضوع',
      status: Status.pending.code.toString(),
      locationStudy: locationStudy(),
      sectionName: section ?? 'بدون',
    );
  }

  Future<void> fecthAllStudents() async {
    try {
      final response = await supabase.from('student').select();
      log('Fetch operation completed.');
      if (response.isEmpty) {
        log("❌ Error: No data fetched");
      } else {
        log("✅ Student fetched successfully: $response");
      }
    } catch (e) {
      log("❌ Error fetching student: $e");
    }
  }

  Future<void> addNewStudent(Student student) async {
    try {
      log('Attempting to add student...');

      await supabase
          .from('student')
          .insert(
            student.toJson(),
          )
          .select();
      log('Insert operation completed.');
    } catch (e) {
      log("❌ Error adding student: $e");
      if (e is PostgrestException) {
        log("Supabase error details: ${e.message}");
      }
    }
  }

  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
