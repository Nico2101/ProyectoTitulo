package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface TemporadaRepository extends JpaRepository<Temporada, Integer> {

	List<Temporada> findByTemporadaEliminadaOrderByEstadoDesc(boolean temporadaEliminada);

	Temporada findByIdTemporada(int idTemporada);

	@Query(value = "SELECT SUM( t.estado ) AS total FROM Temporada t WHERE t.estado = true", nativeQuery = true)
	Integer obtenerTotalTemporadasActivas();
	

	@Query(value = "SELECT *  FROM Temporada WHERE estado ='1' AND temporada_Eliminada ='0'", nativeQuery = true)
	List<Temporada>  totalTemporadasActivas();
	

}
