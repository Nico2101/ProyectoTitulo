package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Empleado;

@Repository
public interface EmpleadoRepository extends JpaRepository<Empleado, String> {

	public Empleado findByRutAndClave(String rut, String clave);

}
