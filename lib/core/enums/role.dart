enum Role {
  ROLE_ADMIN,
  ROLE_STUDENT,
  ROLE_TEACHER,
}

extension RoleString on Role {
  static const Map<Role, String> _roleToString = {
    Role.ROLE_ADMIN: 'role_admin',
    Role.ROLE_STUDENT: 'role_student',
    Role.ROLE_TEACHER: 'role_teacher',
  };

  static const Map<String, Role> _stringToRole = {
    'role_admin': Role.ROLE_ADMIN,
    'role_student': Role.ROLE_STUDENT,
    'role_teacher': Role.ROLE_TEACHER,
  };

  String get toStringValue {
    return _roleToString[this]!;
  }

  static Role fromString(String role) {
    return _stringToRole[role]!;
  }
}
