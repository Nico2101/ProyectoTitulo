package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.repository.EmpleadoRepository;

@Service
public class EmpleadoServiceImplementation implements EmpleadoService {

	private EmpleadoRepository empleadoRepo;

	@Autowired
	public void setEmpleadoRepository(EmpleadoRepository empleadoRepository) {
		empleadoRepo = empleadoRepository;
	}

	@Override
	public Empleado buscarEmpleado(String rut, String clave) {
		// TODO Auto-generated method stub
		return empleadoRepo.findByRutAndClave(rut, clave);
	}

}
