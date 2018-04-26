package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Insumo;

@Repository
public interface ActividadInsumoRepository extends JpaRepository<Actividad_Insumo, Integer> {

}
