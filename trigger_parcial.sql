--trigger


--Función con la lógica que ejecutará nuestro trigger
CREATE OR REPLACE FUNCTION verificar_evento_fn()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	--Para un registro OLD
	branchname varchar;
	departmentname varchar;
	positionName varchar;
	addressDec  varchar;
	supervisorName varchar;
	cityDec  varchar;
	countryDec varchar;
	registeredAtDec  date;
	--Para un registro NEW
	branchnameN varchar;
	departmentnameN varchar;
	positionNameN varchar;
	addressDecN  varchar;
	supervisorNameN varchar;
	cityDecN  varchar;
	countryDecN varchar;
BEGIN
	 SELECT name INTO branchname FROM branchoffice WHERE branchoffice.branchid= OLD.branchid;
	 SELECT name INTO departmentname FROM department WHERE department.deparmentid= OLD.departmentid;
	 SELECT name INTO positionname FROM position WHERE position.positionid = OLD.positionid;
	 SELECT CONCAT(line1, '/', line2) INTO addressDec FROM address WHERE address.addressid = OLD.addressid;
	 SELECT fullname INTO supervisorName FROM employee WHERE employee.employeeid = OLD.supervisorid;
	 SELECT name INTO cityDec FROM city INNER JOIN address ON city.cityid = address.cityid WHERE address.addressid  = OLD.addressid;
	 SELECT country.name INTO countryDec FROM country INNER JOIN city ON country.countryid = city.countryid INNER JOIN address ON address.cityid = city.cityid WHERE address.addressid  = OLD.addressid;
	 registeredAtDec = now();
	 
	 SELECT name INTO branchnameN FROM branchoffice WHERE branchoffice.branchid= NEW.branchid;
	 SELECT name INTO departmentnameN FROM department WHERE department.deparmentid= NEW.departmentid;
	 SELECT name INTO positionnameN FROM position WHERE position.positionid = NEW.positionid;
	 SELECT CONCAT(line1, '/', line2) INTO addressDecN FROM address WHERE address.addressid = NEW.addressid;
	 SELECT fullname INTO supervisorNameN FROM employee WHERE employee.employeeid = NEW.supervisorid;
	 SELECT name INTO cityDecN FROM city INNER JOIN address ON city.cityid = address.cityid WHERE address.addressid  = NEW.addressid;
	 SELECT country.name INTO countryDecN FROM country INNER JOIN city ON country.countryid = city.countryid INNER JOIN address ON address.cityid = city.cityid WHERE address.addressid  = NEW.addressid;
	 
	--Dependiendo del tipo de evento, entrará al IF y hará algún insert
	IF (TG_OP = 'DELETE') THEN
	RAISE NOTICE 'ENTRÓ EN ELIMINADO';
            INSERT INTO employeeAudit VALUES(OLD.employeeid, OLD.fullname, branchname, departmentname, positionName, addressdec, supervisorName, cityDec, countryDec,'DELETE', registeredAtDec );
            RETURN OLD;
	
	ELSIF (TG_OP = 'UPDATE') THEN
	RAISE NOTICE 'ENTRÓ EN ACTUALIZADO';
            INSERT INTO employeeAudit VALUES(OLD.employeeid, OLD.fullname, branchname, departmentname, positionName, addressdec, supervisorName, cityDec, countryDec,'UPDATE', registeredAtDec );
            RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
		RAISE NOTICE 'ENTRÓ EN INSERTADO';
            INSERT INTO employeeAudit VALUES(
				NEW.employeeid, 
				NEW.fullname, branchnameN, departmentnameN, positionNameN, addressdecN, supervisorNameN, cityDecN, countryDecN,
				'INSERT', 
				registeredAtDec );
            RETURN NEW;
	
    END IF;
END;
$$;


--elimina el trigger si ya existe
DROP TRIGGER IF EXISTS verificar_evento_tr ON employee;

--Trigger que ejecuta la funcion de verificacion antes de la insercion, eliminación o actualización en la tabla mascota
CREATE TRIGGER verificar_evento_tr
	AFTER DELETE OR UPDATE OR INSERT
	ON employee
	FOR EACH ROW
	EXECUTE PROCEDURE verificar_evento_fn();
	