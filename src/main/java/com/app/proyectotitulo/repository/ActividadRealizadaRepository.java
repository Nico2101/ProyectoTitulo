package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Realizada;

@Repository
public interface ActividadRealizadaRepository extends JpaRepository<Actividad_Realizada, Integer> {

}
