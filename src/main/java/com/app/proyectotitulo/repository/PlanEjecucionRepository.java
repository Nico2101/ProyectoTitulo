package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.domain.Predio;

@Repository
public interface PlanEjecucionRepository extends JpaRepository<Plan_Ejecucion, Integer> {

	List<Plan_Ejecucion> findByPlanEliminado(boolean planEliminado);

	Plan_Ejecucion findByIdPlanEjecucion(int idPlan);
	
	Plan_Ejecucion findByNombre(String nombre);

}
