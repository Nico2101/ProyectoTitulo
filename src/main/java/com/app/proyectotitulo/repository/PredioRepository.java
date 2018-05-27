package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface PredioRepository extends JpaRepository<Predio, Integer> {
	
	List<Predio> findByPredioEliminado(boolean predioEliminado);// FindAll predio que no están eliminados

	Predio findByIdPredio(int idPredio);
	
	@Query(value="select sum(superficie) as totalSuperficie from Predio p where id_sector=? and predio_Eliminado='0'", nativeQuery=true)
	Integer  superficieTotal(int id_sector);
	
	@Query(value="select* from Predio p where id_sector=? and predio_Eliminado='0'", nativeQuery=true)
	List<Predio>  prediosDeUnSector(int idSector);
	
	

}
