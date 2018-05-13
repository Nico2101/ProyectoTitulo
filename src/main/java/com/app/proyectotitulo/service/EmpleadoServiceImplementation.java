package com.app.proyectotitulo.service;

import java.util.List;

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
	
	
	@Override
		public List<Empleado> listarEmpleados() {
			// TODO Auto-generated method stub
			return empleadoRepo.totalEmpleados();
		}
	
	
	@Override
	public Empleado saveAndFlush(Empleado e) {
		// TODO Auto-generated method stub
		return empleadoRepo.saveAndFlush(e);
	}
	
	@Override
	public Empleado findByRut(String rutEmpleado) {
		// TODO Auto-generated method stub
		return empleadoRepo.findByRut(rutEmpleado);
	}
	
	
	@Override
	public Empleado eliminarEmpleado(Empleado e) {
		// TODO Auto-generated method stub
		return empleadoRepo.save(e);
	}
	
	
	@Override
	public Empleado editarEmpleado(Empleado e) {
		// TODO Auto-generated method stub
		return empleadoRepo.save(e);
	}

}
