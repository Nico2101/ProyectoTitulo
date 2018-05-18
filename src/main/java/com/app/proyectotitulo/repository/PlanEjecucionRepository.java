package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Plan_Ejecucion;

@Repository
public interface PlanEjecucionRepository extends JpaRepository<Plan_Ejecucion, Integer> {

	List<Plan_Ejecucion> findByPlanEliminado(boolean planEliminado);

	Plan_Ejecucion findByIdPlanEjecucion(int idPlan);

}
