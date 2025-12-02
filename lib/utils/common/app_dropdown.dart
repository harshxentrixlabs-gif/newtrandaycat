import 'package:flutter/material.dart';
import '../app_color.dart';
import '../common_font.dart';

class CommonDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;
  final bool autoOpen;

  const CommonDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.autoOpen = false,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  List<String> filteredList = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    filteredList = widget.items;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.autoOpen &&
        widget.items.isNotEmpty &&
        widget.selectedValue.isEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _openDropdown();
      });
    }
  }

  void _openDropdown() {
    filteredList = widget.items;
    searchController.clear();
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, bottomSheet) {
          return DraggableScrollableSheet(
            initialChildSize: 0.65,
            maxChildSize: 0.95,
            minChildSize: 0.45,
            expand: false,
            builder: (_, scrollController) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    widget.hint,
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: AppFont.bold,
                      color: AppColor.textBlack,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔥 Custom Search UI
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: AppColor.textBlack,
                        fontSize: 14,
                      ),
                      onChanged: (value) {
                        bottomSheet(() {
                          filteredList = widget.items
                              .where((item) => item
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(fontFamily: AppFont.medium,),
                        prefixIcon: Container(
                          margin:  EdgeInsets.only(left: 12, right: 10),
                          padding:  EdgeInsets.all(10),
                          decoration:  BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search,
                              color: Colors.white, size: 18),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 50,
                          minHeight: 50,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: filteredList.length,
                    itemBuilder: (_, i) => ListTile(
                      leading: widget.selectedValue == filteredList[i]
                          ? const Icon(Icons.check,
                          size: 18, color: AppColor.primary)
                          : null,
                      title: Text(
                        filteredList[i],
                        style: const TextStyle(
                            fontSize: 14, color: AppColor.textBlack),
                      ),
                      onTap: () {
                        widget.onChanged(filteredList[i]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedValue.isEmpty
                  ? widget.hint
                  : widget.selectedValue,
              style: TextStyle(
                fontSize: 13,
                color: widget.selectedValue.isEmpty
                    ? AppColor.textSecondary
                    : AppColor.textBlack,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp,
                color: AppColor.textBlack),
          ],
        ),
      ),
    );
  }
}
