package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Empleado;

@Repository
public interface EmpleadoRepository extends JpaRepository<Empleado, String> {

	public Empleado findByRutAndClave(String rut, String clave);
	
	//lista todos los empleados menos el administrador
	@Query(value="select* from Empleado where cargo !='administrador' and empleado_Eliminado='0'", nativeQuery=true)
	List<Empleado>  totalEmpleados();
	
	 Empleado findByRut(String rut);

}
