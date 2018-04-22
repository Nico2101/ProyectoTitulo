package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.ActividadInsumo;

@Repository
public interface ActividadInsumoRepository extends JpaRepository<ActividadInsumo, Integer> {

}
