package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad;

@Repository
public interface ActividadRepository extends JpaRepository<Actividad, Integer> {

	List<Actividad> findByPlanEjecucionIdPlanEjecucionAndActividadEliminada(int idPlan, boolean actividadEliminada);

	Actividad findByIdActividad(int idActividad);

}
