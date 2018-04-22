package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.PlanEjecucion;

@Repository
public interface PlanEjecucionRepository extends JpaRepository<PlanEjecucion, Integer> {

}
