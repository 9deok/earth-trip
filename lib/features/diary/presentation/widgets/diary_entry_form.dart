import 'package:flutter/material.dart';
import '../../domain/entities/diary_entry_entity.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/i18n/strings.dart';

class DiaryEntryPayload {
  final DateTime date;
  final int moodScore;
  final String text;
  final String? photoUrl;
  const DiaryEntryPayload({
    required this.date,
    required this.moodScore,
    required this.text,
    this.photoUrl,
  });

  DiaryEntryEntity toEntity(String planId) => DiaryEntryEntity.createNew(
    date: date,
    moodScore: moodScore,
    text: text,
    photoUrl: photoUrl,
    planId: planId,
  );
}

class DiaryEntryForm extends StatefulWidget {
  const DiaryEntryForm({super.key});
  @override
  State<DiaryEntryForm> createState() => _DiaryEntryFormState();
}

class _DiaryEntryFormState extends State<DiaryEntryForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  int _mood = 3;
  String _text = '';
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.only(bottom: insets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => _date = picked);
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          '${_date.year}-${_date.month}-${_date.day}',
                        ),
                      ),
                    ),
                    DropdownButton<int>(
                      value: _mood,
                      onChanged: (v) => setState(() => _mood = v ?? 3),
                      items:
                          List.generate(5, (i) => i + 1)
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text('😊 $v'),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final x = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 85,
                        );
                        if (x != null) setState(() => _image = x);
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('사진 추가'),
                    ),
                    const SizedBox(width: 12),
                    if (_image != null)
                      Expanded(
                        child: Text(
                          _image!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLength: 300,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '오늘의 기록 (최대 300자)',
                  ),
                  validator:
                      (v) =>
                          (v == null || v.trim().isEmpty) ? '내용을 입력하세요' : null,
                  onChanged: (v) => _text = v,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      Navigator.pop(
                        context,
                        DiaryEntryPayload(
                          date: _date,
                          moodScore: _mood,
                          text: _text,
                        ),
                      );
                    },
                    child: const Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
