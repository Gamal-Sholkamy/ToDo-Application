// if (isButtonSheetShow) {
// if (formKey.currentState!.validate()) {
// insertToDatabase(
// title: titleController.text,
// date: dateController.text,
// time: timeController.text)
//     .then((value) {
// getDataFromDatabase(database).then((value) {
// Navigator.pop(context);
// isButtonSheetShow = false;
// setState(() {
// fabIcon = Icons.edit;
// });
// });
//
// });
// }
// } else {
// scaffoldKey.currentState
//     ?.showBottomSheet((context) => Container(
// padding: const EdgeInsets.all(12.0),
// child: Form(
// key: formKey,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// mainAxisSize: MainAxisSize.min,
// children: [
// TextFormField(
// controller: titleController,
// keyboardType: TextInputType.text,
// onFieldSubmitted: (value) {},
// validator: (value) {
// if (value!.isEmpty) {
// return "Title must not be empty";
// } else {
// return null;
// }
// },
// decoration: InputDecoration(
// prefix: const Icon(Icons.title),
// label: const Text("Enter Task Title"),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(0.0))),
// ),
// const SizedBox(
// height: 12.0,
// ),
// TextFormField(
// controller: dateController,
// keyboardType: TextInputType.datetime,
// onFieldSubmitted: (value) {},
// validator: (value) {
// if (value!.isEmpty) {
// return "Title must not be empty";
// } else {
// return null;
// }
// },
// onTap: () {
// showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime.now(),
// lastDate: DateTime(2030))
//     .then((value) {
// dateController.text =
// DateFormat.MMMd().format(value!);
// });
// },
// decoration: InputDecoration(
// prefix: const Icon(Icons.calendar_view_day),
// label: const Text("Enter Task Date"),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(0.0))),
// ),
// const SizedBox(
// height: 12.0,
// ),
// TextFormField(
// controller: timeController,
// keyboardType: TextInputType.datetime,
// onFieldSubmitted: (value) {},
// validator: (value) {
// if (value!.isEmpty) {
// return "Title must not be empty";
// } else {
// return null;
// }
// },
// onTap: () {
// showTimePicker(
// context: context,
// initialTime: TimeOfDay.now())
//     .then((value) {
// timeController.text = value!.format(context);
// });
// },
// decoration: InputDecoration(
// prefix: const Icon(Icons.watch_later_outlined),
// label: const Text("Enter Task Time"),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(0.0))),
// ),
// ],
// ),
// )))
//     .closed
//     .then((value) {
// isButtonSheetShow = false;
// setState(() {
// fabIcon = Icons.edit;
// });
// });
//
// isButtonSheetShow = true;
// setState(() {
// fabIcon = Icons.add;
// });
// }
// }
// ,