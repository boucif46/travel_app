import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travello/services/api_services.dart';

class TravelReservationPage extends StatefulWidget {
 
 final String destinationName ;
 final double price ; 
 final int userId  ;
 final int  destinationId ; 
  TravelReservationPage({super.key, required this.destinationName,required this.price, required this.userId, required this.destinationId});
 
 
  @override
  _TravelReservationPageState createState() => _TravelReservationPageState();
}

class _TravelReservationPageState extends State<TravelReservationPage> {
  late TextEditingController _destinationController;
  late TextEditingController _lastNameController;
  late TextEditingController _adultsController;
  late TextEditingController _childrenController;
  late TextEditingController _priceController;
  late TextEditingController _nameController;
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  double _price = 0;
  double _fullPrice = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _adultsController = TextEditingController();
    _childrenController = TextEditingController();
    _priceController = TextEditingController();
    _checkInDate = DateTime.now();
    _checkOutDate = DateTime.now().add(Duration(days: 1));
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _lastNameController.dispose();
    _adultsController.dispose();
    _childrenController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showCheckInDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: const Text('Starting Trip'),
          content: Container(
            width: 300,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  _checkInDate = args.value;
                });
                Navigator.of(context).pop();
              },
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedRange:
                  PickerDateRange(_checkInDate, _checkOutDate),
            ),
          ),
        );
      },
    );
  }

  void _showCheckOutDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ending Trip'),
          content: Container(
            width: 300,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  _checkOutDate = args.value;
                });
                Navigator.of(context).pop();
              },
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedRange:
                  PickerDateRange(_checkInDate, _checkOutDate),
            ),
          ),
        );
      },
    );
  }
bool sendsuccess  = false;
  Future<bool> _submitReservation(
  int destinationId ,
  int userId,
  String destinationName,
  String name,
  String lastName,
  DateTime startingTrip,
  DateTime endingTrip,
  int adultNumber,
  int childrenNumber,
  BuildContext context) async{
    // Perform submission logic here
    // ...
    if(_formKey.currentState!.validate()){
      ApiService api = ApiService();
      sendsuccess = await  api.sendForm(destinationId, userId, destinationName, name, lastName, startingTrip, endingTrip, adultNumber, childrenNumber, context);
    }
    return sendsuccess ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:  Text('Travel Reservation')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Destination To ${widget.destinationName}",
                  style:const  TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: _adultsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Number of Adults',
                          hintText: '0',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of adults';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _price = 0;
                            _childrenController.text.isEmpty || _childrenController.text.toString() == '0'
                                ? _price += double.parse(value) * widget.price*0.2
                                : _price += double.parse(value) *  widget.price*0.2 +
                                    double.parse(
                                            _childrenController.text.toString()) *
                                         widget.price*0.1;
                            
                            //full price 
        
                            _fullPrice = 0;
                            _childrenController.text.isEmpty
                                ? _fullPrice += double.parse(value) * widget.price
                                : _fullPrice += double.parse(value) * widget.price +
                                    double.parse(
                                            _childrenController.text.toString()) *
                                       ( widget.price-20);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: _childrenController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Number of Children',
                          hintText: '0',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _price = 0;
                            _adultsController.text.isEmpty || _adultsController.text.toString() == '0'
                                ? _price += double.parse(value) * widget.price * 0.1
                                : _price += double.parse(value) *  widget.price * 0.1+
                                    double.parse(
                                            _adultsController.text.toString()) *
                                         widget.price * 0.2;
                            //full price 
                            _fullPrice = 0;
                            _adultsController.text.isEmpty
                                ? _fullPrice += double.parse(value) * (widget.price-20)
                                : _fullPrice += double.parse(value) * (widget.price-20) +
                                    double.parse(
                                            _adultsController.text.toString()) *
                                        widget.price;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Starting Trip'),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _showCheckInDatePicker(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('yyyy-MM-d').format(_checkInDate),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Ending Trip'),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _showCheckOutDatePicker(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                               const  Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('yyyy-MM-d').format(_checkOutDate),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  child: Row(
                    children: List.generate(
                        100,
                        (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.black,
                                height: 2,
                              ),
                            )),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Booking Price is :",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "\$$_price",
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ]
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Full Price is :",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "\$$_fullPrice",
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ]
                    )
        
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: 
                    (){
                      _submitReservation(
                    widget.destinationId,
                    widget.userId,
                    widget.destinationName,
                    _nameController.text,
                    _lastNameController.text,
                    _checkInDate,
                    _checkOutDate,
                    int.parse(_adultsController.text),
                    int.parse(_childrenController.text),
                    context);
                    Navigator.pop(context);
                    },
                  child:const  Text('  Submit  '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
