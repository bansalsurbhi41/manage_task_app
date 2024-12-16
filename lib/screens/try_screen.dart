//
//
// class EditTaskScreen extends StatefulWidget {
//   const EditTaskScreen({super.key, required this.task});
//
//   final Task task;
//
//   @override
//   State<EditTaskScreen> createState() => _EditTaskScreenState();
// }
//
// class _EditTaskScreenState extends State<EditTaskScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),
//
//               /// Title String
//               TitleField(titleController: titleController),
//               const SizedBox(
//                 height: 20,
//               ),
//
//               CommonButton(
//                   buttonText: StringConst.kEditTask,
//                   buttonOnTap: () {
//                     context.read<TaskManageBloc>().add(
//                         EditTaskEvent(
//                             taskId: widget.task.id ?? 0,
//                             title: widget.task.title != titleController.text.trim() ? titleController.text.trim() : null,
//                             description: widget.task.description != descriptionController.text.trim() ? descriptionController.text.trim() : null));
//                   },
//                   buttonColor: UIColors.purple)
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: ,
//     );
//   }
// }
