/*
 * @Author: jackning 270580156@qq.com
 * @Date: 2024-08-12 08:50:51
 * @LastEditors: jackning 270580156@qq.com
 * @LastEditTime: 2024-08-12 21:51:02
 * @Description: bytedesk.com https://github.com/Bytedesk/bytedesk
 *   Please be aware of the BSL license restrictions before installing Bytedesk IM – 
 *  selling, reselling, or hosting Bytedesk IM as a service is a breach of the terms and automatically terminates your rights under the license. 
 *  仅支持企业内部员工自用，严禁私自用于销售、二次销售或者部署SaaS方式销售 
 *  Business Source License 1.1: https://github.com/Bytedesk/bytedesk/blob/main/LICENSE 
 *  contact: 270580156@qq.com 
 *  联系：270580156@qq.com
 * Copyright (c) 2024 by bytedesk.com, All Rights Reserved. 
 */
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../api/contact_repository.dart';
import '../model/contact_data.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends HydratedBloc<ContactEvent, ContactState> {
  //
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository)
      : super(ContactState(contactData: ContactData.init())) {
    on<GetContactEvent>(_mapGetContactEventToState);
  }

  void _mapGetContactEventToState(
      GetContactEvent event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    try {
      final ContactData tikuData =
          await _contactRepository.queryContact(event.page, event.size!);
      emit(
          state.copyWith(status: ContactStatus.success, contactData: tikuData));
    } catch (error) {
      emit(state.copyWith(status: ContactStatus.failure));
    }
  }

  @override
  ContactState? fromJson(Map<String, dynamic> json) {
    // debugPrint("ContactState fromJson $json");
    return ContactState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ContactState state) {
    // debugPrint("ContactState toJson ${state.toJson()}");
    return state.toJson();
  }
}
