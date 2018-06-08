package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Reprogramacion;

@Repository
public interface ReprogramacionRepository extends JpaRepository<Reprogramacion, Integer> {

	List<Reprogramacion> findByActividadRealizadaIdActividadRealizadaOrderByFechaEstimadaAnteriorAsc(int idActividadRealizada);

}
