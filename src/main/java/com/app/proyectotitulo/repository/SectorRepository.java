package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.domain.Sector;

@Repository
public interface SectorRepository extends JpaRepository<Sector, Integer> {
	
	List<Sector> findBySectorEliminado(boolean sectorEliminado);
	
	Sector findByIdSector(int idSector);
	

}
