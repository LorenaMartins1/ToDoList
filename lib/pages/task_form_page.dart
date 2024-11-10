import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskFormPage extends StatefulWidget {
  final Function(Task) onSubmit;
  final Task? existingTask;

  TaskFormPage({required this.onSubmit, this.existingTask});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  DateTime? _dueDate;
  String? _category;
  final _categories = ['Trabalho', 'Pessoal', 'Estudos'];

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      _title = widget.existingTask!.title;
      _description = widget.existingTask!.description;
      _dueDate = widget.existingTask!.dueDate;
      _category = widget.existingTask!.category;
    } else {
      _title = '';
      _description = '';
      _dueDate = DateTime.now();
      _category = _categories.first;
    }
  }

  void _selectDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(Task(_title, _description, _dueDate!, _category!));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingTask == null ? 'Nova Tarefa' : 'Editar Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                style: const TextStyle(color: Color.fromARGB(255, 49, 47, 47)),
                decoration: const InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
                onChanged: (value) => _title = value,
              ),
              TextFormField(
                initialValue: _description,
                style: const TextStyle(color: Color.fromARGB(255, 49, 47, 47)),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) => _description = value,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) => setState(() => _category = value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Alinha à esquerda
                children: [
                  IconButton(
                    onPressed: _selectDueDate,
                    icon: Icon(Icons.calendar_today),
                    tooltip: 'Escolher Data de Vencimento',
                    color: Colors.purple,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child:
                    Text(widget.existingTask == null ? 'Adicionar' : 'Salvar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
