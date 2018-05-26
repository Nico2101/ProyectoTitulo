package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.app.proyectotitulo.domain.Sector;

@Repository
public interface SectorRepository extends JpaRepository<Sector, Integer> {
	
	List<Sector> findBySectorEliminadoOrderByNombreAsc(boolean sectorEliminado);
	
	Sector findByIdSector(int idSector);
	
	@Query(value="select superficie from Sector where id_sector=?", nativeQuery=true)
	Integer  TotalSuperSector(int id_sector);
	
	
	

}
