import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pagination_entity.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  const PaginationModel({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  PaginationEntity toEntity() {
    return PaginationEntity(
      totalCount: totalCount,
      perPage: perPage,
      maxPage: maxPage,
      currentPage: currentPage,
    );
  }
}
