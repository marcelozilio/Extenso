  MEMBER('extenso.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('EXTENBC0.CLW')
EXTENBC0:DctInit             PROCEDURE
EXTENBC0:DctKill             PROCEDURE
EXTENBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  EXTENBC0:DctInit
  EXTENBC0:FilesInit


DctKill PROCEDURE
  CODE
  EXTENBC0:DctKill

