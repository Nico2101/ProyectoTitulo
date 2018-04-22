package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Predio;

@Repository
public interface PredioRepository extends JpaRepository<Predio, Integer> {

}
