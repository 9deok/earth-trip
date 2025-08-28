import 'package:flutter/material.dart';
import '../../domain/entities/diary_entry_entity.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/i18n/strings.dart';

class DiaryEntryForm extends StatefulWidget {
  final String planId;
  final DiaryEntryEntity? initial;
  const DiaryEntryForm({super.key, required this.planId, this.initial});
  @override
  State<DiaryEntryForm> createState() => _DiaryEntryFormState();
}

class _DiaryEntryFormState extends State<DiaryEntryForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  int _mood = 3;
  String _text = '';
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _date = widget.initial?.date ?? DateTime.now();
    _mood = widget.initial?.moodScore ?? 3;
    _text = widget.initial?.text ?? '';
  }

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
                      label: Text(Strings.Diary.addPhoto),
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
                          (v == null || v.trim().isEmpty)
                              ? Strings.Diary.entryRequired
                              : null,
                  onChanged: (v) => _text = v,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      final photoUrl = _image?.path ?? widget.initial?.photoUrl;
                      DiaryEntryEntity entity;
                      if (widget.initial != null) {
                        entity = DiaryEntryEntity(
                          id: widget.initial!.id,
                          date: _date,
                          moodScore: _mood,
                          text: _text,
                          photoUrl: photoUrl,
                          planId: widget.planId,
                          isRetrospective: widget.initial!.isRetrospective,
                        );
                      } else {
                        entity = DiaryEntryEntity.createNew(
                          date: _date,
                          moodScore: _mood,
                          text: _text,
                          photoUrl: photoUrl,
                          planId: widget.planId,
                        );
                      }
                      Navigator.pop(context, entity);
                    },
                    child: Text(Strings.Diary.save),
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
