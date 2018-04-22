package com.app.proyectotitulo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Sector;

@Repository
public interface SectorRepository extends JpaRepository<Sector, Integer> {

}
