package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface TemporadaRepository extends JpaRepository<Temporada, Integer> {

}
