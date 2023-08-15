import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notepad/domain/model/error.dart';
import 'package:notepad/domain/repository/note_repository.dart';

@injectable
class DeleteNoteUsecase {
  const DeleteNoteUsecase(this._repository);
  final NoteRepository _repository;

  Future<Either<NoteError, Unit>> call(String id) async {
    try {
      await _repository.deleteNote(id);
      return right(unit);
    } on Exception catch (_) {
      return left(
        NoteError(message: 'Failed to delete note, please try again.'),
      );
    }
  }
}
