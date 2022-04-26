--lab5

CREATE DATABASE �����_118    -- ������ ��� ���������� ���� ���������� ����
 ON PRIMARY                   -- ���� D:\Work\X7230XXX\ � ������
   ( NAME = �����_data,       -- ���� ������ ��� ������ ������������
     FILENAME = 'E:\SQL\4\�����_118__data.mdf',
     SIZE = 5MB, 
     MAXSIZE = 75MB,
     FILEGROWTH = 3MB ),
 FILEGROUP Secondary
   ( NAME = �����2_data,
     FILENAME = 'E:\SQL\4\�����_118__data2.ndf',
     SIZE = 3MB, 
     MAXSIZE = 50MB,
     FILEGROWTH = 15% ),
   ( NAME = �����3_data,
     FILENAME = 'E:\SQL\4\�����_118__data3.ndf',
     SIZE = 4MB, 
     FILEGROWTH = 4MB )
 LOG ON
   ( NAME = �����_log,
     FILENAME = 'E:\SQL\4\�����_118__log.ldf',
     SIZE = 1MB,
     MAXSIZE = 10MB,
     FILEGROWTH = 20% ),
   ( NAME = �����2_log,
     FILENAME = 'E:\SQL\4\�����_118__log2.ldf',
     SIZE = 512KB,
     MAXSIZE = 15MB,
     FILEGROWTH = 10% )
 GO  

 USE �����_118
 GO

 CREATE RULE Logical_rule AS @value IN ('���', '��')
 GO

 CREATE DEFAULT Logical_default AS '���'
 GO

 EXEC sp_addtype Logical, 'char(3)', 'NOT NULL'
 GO

 EXEC sp_bindrule 'Logical_rule', 'Logical'
 GO

 /* ������ */
 CREATE TABLE ������ (				/* ������ ������� ������ */
   ����������	INT  PRIMARY KEY,
   ������		VARCHAR(20)  DEFAULT '��������'  NOT NULL,
   �������	VARCHAR(20)  NOT NULL,
   �����		VARCHAR(20)  NOT NULL,
   �����		VARCHAR(50)  NOT NULL,
   �������	CHAR(15)  NULL,
   ����		CHAR(15)  NOT NULL  CONSTRAINT CIX_������2
     UNIQUE  ON Secondary,
   CONSTRAINT CIX_������  UNIQUE (������, �������, �����, �����)
     ON Secondary
 )

  /* ��������� */
 CREATE TABLE ��������� (			/* ������ ������� ������ */
   �������������	INT  PRIMARY KEY,
   �������������	VARCHAR(40)  NOT NULL,
   �������������	VARCHAR(30)  DEFAULT '����������'  NULL,
   ����������		INT  NULL,
   �������		VARCHAR(MAX)  NULL,
   CONSTRAINT  FK_���������_������  FOREIGN KEY (����������)
     REFERENCES  ������  ON UPDATE CASCADE
 )

  /* ������ */
 CREATE TABLE ������ (				/* ������ ������� ������ */
   ����������	 	INT  IDENTITY(1,1)  PRIMARY KEY,
   ����������		VARCHAR(40)  NOT NULL,
   ���������������	VARCHAR(60)  NULL,
   ���������� 		INT  NULL,
   CONSTRAINT  FK_������_������  FOREIGN KEY (����������)
     REFERENCES  ������  ON UPDATE CASCADE
 )

  /* ������ */
 CREATE TABLE ������ (				/* ��������� ������� ������ */
   ���������		CHAR(3)  PRIMARY KEY,
   ���������		VARCHAR(30)  NOT NULL,
   ������������� 	NUMERIC(10, 4)  DEFAULT 0.01  NULL
     CHECK (������������� IN (50, 1, 0.01)),
   ����������  	SMALLMONEY  NOT NULL  CHECK (���������� > 0)
 )

  /* ����� */
 CREATE TABLE ����� (				/* ����� ������� ������ */
   ���������		INT  PRIMARY KEY,
   ������������	VARCHAR(50)  NOT NULL,
   ����������  	CHAR(10)  DEFAULT '�����'  NULL,
   ����			MONEY  NULL  CHECK (���� > 0),
   ���������		CHAR(3)  DEFAULT 'BYR'  NULL,
   ����������		LOGICAL  NOT NULL,
   CONSTRAINT  FK_�����_������  FOREIGN KEY (���������)
     REFERENCES  ������  ON UPDATE CASCADE
 )

  /* ����� */
 CREATE TABLE ����� (				/* ������ ������� ������ */
   ���������		INT  IDENTITY(1,1)  NOT NULL,
   ����������	 	INT  NOT NULL,
   ���������   	INT  NOT NULL,
   ����������		NUMERIC(12, 3)  NULL  CHECK (���������� > 0),
   ����������	 	DATETIME  DEFAULT getdate()  NULL,
   ������������	DATETIME  DEFAULT getdate() + 14  NULL,
   �������������	INT  NULL,  					
   PRIMARY KEY (���������, ����������, ���������),
   CONSTRAINT  FK_�����_�����  FOREIGN KEY (���������)  
     REFERENCES  �����  ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT  FK_�����_������  FOREIGN KEY (����������)
     REFERENCES  ������  ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT  FK_�����_���������  FOREIGN KEY (�������������)
     REFERENCES  ���������
 )
 GO

 CREATE UNIQUE INDEX  UIX_���������  ON ��������� (�������������)
   ON Secondary
 CREATE UNIQUE INDEX  UIX_������  ON ������ (����������)
   ON Secondary
 CREATE UNIQUE INDEX  UIX_������  ON ������ (���������)
   ON Secondary
 CREATE UNIQUE INDEX  UIX_�����  ON ����� (������������)
   ON Secondary
 CREATE INDEX  IX_������  ON ������ (������, �����)  ON Secondary
 CREATE INDEX  IX_�����  ON ����� (����������, ������������)
   ON Secondary
 CREATE INDEX  IX_�����  ON ����� (����������)  ON Secondary
 GO

 INSERT INTO ������
 VALUES (101, '������', '����������', '�������', '��.����, 15',
   '387-23-04', '387-23-05')

 INSERT INTO ������ (����������, �������, �����, �����, ����)
 VALUES (201, '', '�����', '��.������, 9', '278-83-88')	

 INSERT INTO ������ (����������, �������, �����, �����, ����)
 VALUES (202, '�������', '�������', '��.������, 11', '48-37-92')

 INSERT INTO ������ (����������, �������, �����, �����, �������,
   ����)
 VALUES (203, '', '�����', '��.������, 24', '269-13-76',
   '269-13-77')	

 INSERT INTO ������ (����������, �������, �����, �����, ����)
 VALUES (204, '���������', '������', '��.������, 6', '48-24-12')

 INSERT INTO ������ 
 VALUES (301, '�������', '��������', '������', '��.������, 24',
   NULL, '46-49-16')	
 GO

 INSERT INTO ��������� (�������������, �������������, ����������)
VALUES (123, '��� ����������', 101)
INSERT INTO ��������� (�������������, �������������, ����������)
VALUES (345, '��� ����������', 202)
INSERT INTO ���������
VALUES (987, '��� �����������', '��������', 204,
'���������� ���������')
INSERT INTO ��������� (�������������, �������������, ����������)
VALUES (789, '�� ������� �. �.', 301)
INSERT INTO ���������
VALUES (567, '�� ��������', '�� ����� ��������', 203,
'���������� ���������')
GO

INSERT INTO ������
VALUES ('�� ������', '�������� ��������� ��������', 202)
INSERT INTO ������ (����������, ���������������)
VALUES ('�� �������', '����� �. �.')
INSERT INTO ������
VALUES ('��� ��������', '��������� �. �.', 203)
INSERT INTO ������
VALUES ('��� ��������', '���������� �. �.', 301)
INSERT INTO ������ (����������, ���������������)
VALUES ('�� �����', '������ �������� �����������')
GO

INSERT INTO ������
 VALUES ('BYR', '����������� �����', 1, 1)

 INSERT INTO ������ (���������, ���������, ����������)
 VALUES ('RUR', '���������� �����', 276)

 INSERT INTO ������ (���������, ���������, ����������)
 VALUES ('USD', '������� ���', 9160)

 INSERT INTO ������ (���������, ���������, ����������)
 VALUES ('EUR', '����', 12450)
 GO

 INSERT INTO �����
VALUES (111, '������� 21 ����', '�����', 320, 'USD', '���')
INSERT INTO �����
VALUES (222, '���� ������������ Canyon', '�����', 5, 'EUR', '���')
INSERT INTO �����
VALUES (333, '�������� ���������� Lenovo', '�����', 35, 'BYR', '��')
INSERT INTO ����� (���������, ������������, ����, ����������)
VALUES (444, '�������� Asus', 1200, '���')
INSERT INTO ����� (���������, ������������, ����, ����������)
VALUES (555, '��������� HDD 120GB', 285000, '��')
GO

SET DATEFORMAT dmy

INSERT INTO �����
VALUES (3, 111, 8, '04/09/19', '14/09/19', 567)
INSERT INTO �����
VALUES (2, 222, 10, '04/01/20', '14/01/20', 987)
INSERT INTO �����
VALUES (5, 333, 15, '22/02/20', '28/02/20', 789)
INSERT INTO �����
VALUES (4, 444, 20, '05/04/2020', '20/04/2020', 345)
INSERT INTO ����� (����������, ���������, ����������)
VALUES (1, 555, 25)
GO

 CREATE VIEW ������1 AS
   SELECT TOP 100 PERCENT �����.������������, �����.����������, 
     �����.����������, ���������.�������������
   FROM ����� 
     INNER JOIN ��������� 
       ON �����.������������� = ���������.������������� 
     INNER JOIN ����� 
       ON �����.��������� = �����.���������
   ORDER BY �����.������������, �����.���������� DESC 
 GO

EXEC sp_addlogin 'sql1', '1111', '�����_118';
EXEC sp_addlogin 'sql2', '1111', '�����_118';
EXEC sp_addlogin 'sql3', '1111', '�����_118';
EXEC sp_addlogin 'sql4', '1111', '�����_118';
GO

EXEC sp_addsrvrolemember 'sql1', 'dbcreator'
GO

EXEC sp_grantdbaccess 'sql1', 'login1'
EXEC sp_grantdbaccess 'sql2', 'login2'
EXEC sp_grantdbaccess 'sql3', 'login3'
EXEC sp_grantdbaccess 'sql4', 'login4'
GO

EXEC sp_addrole '��.���������', 'login1'
EXEC sp_addrole '����������', 'login1'
EXEC sp_addrole '����������', 'login1'
GO

EXEC sp_addrolemember 'db_accessadmin', 'login1'
EXEC sp_addrolemember '��.���������', 'login1'
EXEC sp_addrolemember '����������', 'login2'
EXEC sp_addrolemember '����������', 'login3'
EXEC sp_addrolemember '����������', '��.���������'
EXEC sp_addrolemember '����������', 'login4'
EXEC sp_addrolemember '����������', '��.���������'
GO

GRANT SELECT, INSERT, UPDATE, DELETE
 ON ������ TO [��.���������] WITH GRANT OPTION

 GRANT UPDATE
 ON ����� TO [��.���������] WITH GRANT OPTION

 GRANT SELECT
 ON ������1 TO [��.���������] WITH GRANT OPTION

 GRANT UPDATE, DELETE
 ON ������ TO [��.���������] WITH GRANT OPTION

 GRANT UPDATE, DELETE
 ON ��������� TO [��.���������] WITH GRANT OPTION

 GRANT UPDATE, DELETE
 ON ����� TO [��.���������] WITH GRANT OPTION

 GRANT SELECT, INSERT
 ON ����� TO ����������

 GRANT SELECT, INSERT
 ON ������ TO ����������

 GRANT SELECT, INSERT
 ON ��������� TO ����������

 GRANT SELECT, INSERT
 ON ����� TO ����������

 GRANT SELECT, INSERT, UPDATE, DELETE
 ON ������ TO public
 GO

 DENY UPDATE
 ON ����� (����������, ������������) TO [��.���������] CASCADE 
 GO



