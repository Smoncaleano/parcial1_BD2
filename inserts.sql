--Algunos inserts de la bd

--Insert de employee
INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ( 'NUEVO', 1, 1, 1, 1, 2);
	
INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ( 'Prueba parcial', 1, 1, 1, 1, 2);
	
INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ( 'NUEVA PRUEBA 02', 1, 1, 1, 1, 2);
	
--Insert en Addres, para la sucursal US
INSERT INTO public.address(
	 line1, line2, cityid)
	VALUES ('Sucursal US', 'ESQUINA', '1');

--Insert para la creación de la sucursal US
INSERT INTO public.branchoffice(
	branchid, name, addressid)
	VALUES (999, 'US', 4);
	
--Insert de empleados en sucursal US
INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ('primero en sucursal', 999, 1, 2, 1, 2);
	
INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ('tercero en sucursal', 999, 1, 2, 3, 2);

INSERT INTO public.employee(
	 fullname, branchid, departmentid, positionid, addressid, supervisorid)
	VALUES ('segundo en sucursal', 999, 1, 2, 4, 2);
	
--Update de empleados de la sucursal US
UPDATE public.employee
	SET fullname='CAMBIO DE NOMBRE'
	WHERE employee.employeeid=28;