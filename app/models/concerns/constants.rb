module Constants
  DEPARTMENTS = {
    general:     0,
    information: 1,
    electronics: 2,
    mechanical:  3,
    system:      4,
    chemistry:   5,
    advanced_ei: 6,
    advanced_ms: 7,
    advanced_c:  8,
  }

  DEPARTMENTS_LOCALE = DEPARTMENTS.keys.map{|department|
    [I18n.t("activerecord.modules.constants.departments.#{department.to_s}"), department.to_s]
  }
end
