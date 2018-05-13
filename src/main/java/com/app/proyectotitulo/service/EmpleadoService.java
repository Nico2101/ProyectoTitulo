package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Empleado;

public interface EmpleadoService {

	public Empleado buscarEmpleado(String rut, String clave);
	
	
	List<Empleado> listarEmpleados();

	Empleado saveAndFlush(Empleado e);
	
	 Empleado findByRut(String rutEmpleado);
	
	// Eliminar empleado
	Empleado eliminarEmpleado(Empleado e);
	
	// Editar empleado
	Empleado editarEmpleado(Empleado e);
}
