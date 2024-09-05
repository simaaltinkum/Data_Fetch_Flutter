// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropbox_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DropboxStore on _DropboxStore, Store {
  late final _$dropboxFilesAtom =
      Atom(name: '_DropboxStore.dropboxFiles', context: context);

  @override
  ObservableList<String> get dropboxFiles {
    _$dropboxFilesAtom.reportRead();
    return super.dropboxFiles;
  }

  @override
  set dropboxFiles(ObservableList<String> value) {
    _$dropboxFilesAtom.reportWrite(value, super.dropboxFiles, () {
      super.dropboxFiles = value;
    });
  }

  late final _$fetchDropboxFilesAsyncAction =
      AsyncAction('_DropboxStore.fetchDropboxFiles', context: context);

  @override
  Future<void> fetchDropboxFiles() {
    return _$fetchDropboxFilesAsyncAction.run(() => super.fetchDropboxFiles());
  }

  @override
  String toString() {
    return '''
dropboxFiles: ${dropboxFiles}
    ''';
  }
}
