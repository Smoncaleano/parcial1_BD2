--Vista que por seguridad sólo permite a la Sucursal US con el Id 999, ver el historial de cambios de un empleado en su departamento y posición
CREATE VIEW empleados_US AS
    SELECT employeeid, fullname, department, position 
    FROM employeeaudit INNER JOIN branchoffice AS pq ON pq.name = employeeaudit.branch
    WHERE pq.branchid = 999 ORDER BY employeeaudit.employeeid;

--Select sobre la vista para probar su funcionamiento
SELECT * FROM empleados_US;