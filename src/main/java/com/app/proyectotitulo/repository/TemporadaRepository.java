package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface TemporadaRepository extends JpaRepository<Temporada, Integer> {

	List<Temporada> findByTemporadaEliminadaOrderByIdTemporadaDesc(boolean temporadaEliminada);

	Temporada findByIdTemporada(int idTemporada);

}
