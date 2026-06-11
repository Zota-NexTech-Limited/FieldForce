import 'package:fieldsales/helper/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _defaultFileNameController = TextEditingController();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final _fileExtensionController = TextEditingController();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  @override
  void initState() {
    super.initState();
    _fileExtensionController
        .addListener(() => _extension = _fileExtensionController.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.clearTemporaryFiles();
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            (result!
                ? 'Temporary files removed with success.'
                : 'Failed to clean temporary files'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _selectFolder() async {
    _resetState();
    try {
      String? path = await FilePicker.getDirectoryPath(
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      );
      setState(() {
        _directoryPath = path;
        _userAborted = path == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFile() async {
    _resetState();
    try {
      String? fileName = await FilePicker.saveFile(
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        type: _pickingType,
        dialogTitle: _dialogTitleController.text,
        fileName: _defaultFileNameController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      );
      setState(() {
        _saveAsFileName = fileName;
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  TextStyle get _sectionTitleStyle => const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: COLORS.textPrimary,
      );

  InputDecoration _fieldDecoration({required String label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: COLORS.surfaceMuted,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: COLORS.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: COLORS.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: COLORS.primaryColor, width: 1.6),
      ),
    );
  }

  Widget _card({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: COLORS.cardBorder),
        boxShadow: const [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _sectionTitleStyle),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    final Color base = color ?? COLORS.primaryColor;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: base,
        foregroundColor: COLORS.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _resultRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? iconColor,
    Color? iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg ?? COLORS.primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor ?? COLORS.primaryColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: COLORS.textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.5,
                      color: COLORS.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: COLORS.scaffoldBg,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: COLORS.textPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: COLORS.scaffoldBg,
        appBar: AppBar(
          backgroundColor: COLORS.surface,
          foregroundColor: COLORS.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          shadowColor: COLORS.shadow,
          title: const Text(
            'File Picker',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: COLORS.textPrimary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _card(
                title: 'Configuration',
                children: [
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      SizedBox(
                        width: 400,
                        child: TextField(
                          decoration:
                              _fieldDecoration(label: 'Dialog Title'),
                          controller: _dialogTitleController,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          decoration:
                              _fieldDecoration(label: 'Initial Directory'),
                          controller: _initialDirectoryController,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          decoration:
                              _fieldDecoration(label: 'Default File Name'),
                          controller: _defaultFileNameController,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: DropdownButtonFormField<FileType>(
                          value: _pickingType,
                          icon: const Icon(Icons.expand_more),
                          alignment: Alignment.centerLeft,
                          decoration: _fieldDecoration(label: 'File Type'),
                          items: FileType.values
                              .map(
                                (fileType) => DropdownMenuItem<FileType>(
                                  child: Text(fileType.toString()),
                                  value: fileType,
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(
                            () {
                              _pickingType = value!;
                              if (_pickingType != FileType.custom) {
                                _fileExtensionController.text =
                                    _extension = '';
                              }
                            },
                          ),
                        ),
                      ),
                      _pickingType == FileType.custom
                          ? SizedBox(
                              width: 400,
                              child: TextFormField(
                                decoration: _fieldDecoration(
                                  label: 'File Extension',
                                  hint: 'jpg, png, gif',
                                ),
                                autovalidateMode: AutovalidateMode.always,
                                controller: _fileExtensionController,
                                keyboardType: TextInputType.text,
                                maxLength: 15,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 12.0,
                    runSpacing: 4.0,
                    children: [
                      SizedBox(
                        width: 400.0,
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: COLORS.primaryColor,
                          title: const Text(
                            'Lock parent window',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: COLORS.textPrimary,
                            ),
                          ),
                          onChanged: (bool value) =>
                              setState(() => _lockParentWindow = value),
                          value: _lockParentWindow,
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints.tightFor(width: 400.0),
                        child: SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: COLORS.primaryColor,
                          title: const Text(
                            'Pick multiple files',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: COLORS.textPrimary,
                            ),
                          ),
                          onChanged: (bool value) =>
                              setState(() => _multiPick = value),
                          value: _multiPick,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _card(
                title: 'Actions',
                children: [
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: <Widget>[
                      _actionButton(
                        icon: Icons.description,
                        label: _multiPick ? 'Pick files' : 'Pick file',
                        onPressed: () => _pickFiles(),
                      ),
                      _actionButton(
                        icon: Icons.folder,
                        label: 'Pick folder',
                        onPressed: () => _selectFolder(),
                      ),
                      _actionButton(
                        icon: Icons.save_as,
                        label: 'Save file',
                        color: COLORS.success,
                        onPressed: () => _saveFile(),
                      ),
                      _actionButton(
                        icon: Icons.delete_forever,
                        label: 'Clear temporary files',
                        color: COLORS.danger,
                        onPressed: () => _clearCachedFiles(),
                      ),
                    ],
                  ),
                ],
              ),
              _card(
                title: 'File Picker Result',
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Builder(
                      key: ValueKey<String>(
                        '$_isLoading|$_userAborted|$_directoryPath|'
                        '${_paths?.length}|$_saveAsFileName',
                      ),
                      builder: (BuildContext context) => _isLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : _userAborted
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 28.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: _resultRow(
                                    icon: Icons.error_outline,
                                    iconColor: COLORS.warning,
                                    iconBg: COLORS.warningSoft,
                                    title: 'User has aborted the dialog',
                                    subtitle: '',
                                  ),
                                )
                              : _directoryPath != null
                                  ? _resultRow(
                                      icon: Icons.folder_open,
                                      title: 'Directory path',
                                      subtitle: _directoryPath!,
                                    )
                                  : _paths != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: COLORS.surfaceMuted,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: COLORS.cardBorder,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.50,
                                          child: Scrollbar(
                                            child: ListView.separated(
                                              itemCount: _paths != null &&
                                                      _paths!.isNotEmpty
                                                  ? _paths!.length
                                                  : 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final bool isMultiPath =
                                                    _paths != null &&
                                                        _paths!.isNotEmpty;
                                                final String name =
                                                    'File $index: ' +
                                                        (isMultiPath
                                                            ? _paths!
                                                                .map((e) =>
                                                                    e.name)
                                                                .toList()[index]
                                                            : _fileName ??
                                                                '...');
                                                final path = kIsWeb
                                                    ? null
                                                    : _paths!
                                                        .map((e) => e.path)
                                                        .toList()[index]
                                                        .toString();

                                                return _resultRow(
                                                  icon: Icons
                                                      .insert_drive_file_outlined,
                                                  title: name,
                                                  subtitle: path ?? '',
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(
                                                height: 1,
                                                color: COLORS.divider,
                                                indent: 14,
                                                endIndent: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                      : _saveAsFileName != null
                                          ? _resultRow(
                                              icon: Icons.save_outlined,
                                              iconColor: COLORS.success,
                                              iconBg: COLORS.successSoft,
                                              title: 'Save file',
                                              subtitle: _saveAsFileName!,
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 24.0,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'No result yet',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: COLORS.textTertiary,
                                                ),
                                              ),
                                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}