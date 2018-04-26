package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Plan_Ejecucion;

@Repository
public interface PlanEjecucionRepository extends JpaRepository<Plan_Ejecucion, Integer> {

}
