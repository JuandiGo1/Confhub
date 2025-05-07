import 'package:confhub/data/models/feedback_model.dart';

/// Función para filtrar y ordenar feedbacks
  List<FeedbackModel> filterAndSortFeedbacks(
      List<FeedbackModel> feedbacks, String filtro) {
    if (filtro == "Recientes") {
      feedbacks.sort((f1, f2) {
        return f2.dateTime.compareTo(f1.dateTime); // Más recientes primero
      });
    } else if (filtro == "Antiguos") {
      feedbacks.sort((f1, f2) {
        return f1.dateTime.compareTo(f2.dateTime); // Más antiguos primero
      });
    } else if (filtro == "MejorVal") {
      feedbacks.sort((f1, f2) {
        return (f2.likes - f2.dislikes).compareTo(f1.likes - f1.dislikes);
      });
    } else if (filtro == "PeorVal") {
      feedbacks.sort((f1, f2) {
        return (f1.likes - f1.dislikes).compareTo(f2.likes - f2.dislikes);
      });
    }

    return feedbacks;
  }