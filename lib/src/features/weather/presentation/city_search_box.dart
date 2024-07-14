import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:provider/provider.dart';

class CitySearchBox extends StatefulWidget {
  final String buttonText;
  final String validationMessage;

  const CitySearchBox({
    super.key,
    required this.buttonText,
    required this.validationMessage,
  });

  @override
  State<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends State<CitySearchBox> {
  static const _radius = 30.0;

  late WeatherProvider weatherProvider;
  late final _searchController = TextEditingController();

  late bool showValidation = false;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SizedBox(
            height: _radius * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_radius),
                          bottomLeft: Radius.circular(_radius),
                        ),
                      ),
                    ),
                    onChanged: (value) => setState(
                      () => showValidation = value.isEmpty,
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_radius),
                        bottomRight: Radius.circular(_radius),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.buttonText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_searchController.text.isNotEmpty) {
                      weatherProvider.getWeather(city: _searchController.text);
                    } else {
                      setState(() => showValidation = true);
                    }
                  },
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: !showValidation,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              widget.validationMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.accentColor,
                  ),
            ),
          ),
        )
      ],
    );
  }

  void _loadContent() {
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    _searchController.text = weatherProvider.city;
  }
}
