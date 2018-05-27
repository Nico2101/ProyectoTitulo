package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface PredioRepository extends JpaRepository<Predio, Integer> {

	List<Predio> findByPredioEliminadoOrderByNombreAsc(boolean predioEliminado);// FindAll predio que no están
																				// eliminados

	Predio findByIdPredio(int idPredio);

	@Query(value = "select sum(superficie) as totalSuperficie from Predio p where id_sector=? and predio_Eliminado='0'", nativeQuery = true)
	Integer superficieTotal(int id_sector);

	@Query(value = "select* from Predio p where id_sector=? and predio_Eliminado='0'", nativeQuery = true)
	List<Predio> prediosDeUnSector(int idSector);

	@Query(value = "SELECT * FROM Predio p WHERE p.id_predio IN (SELECT ar.id_predio FROM Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE t.estado =1 AND t.temporada_eliminada=0 AND p.id_predio = ar.id_predio AND p.estado !=  'Cosechado' AND p.predio_eliminado =0 and p.id_sector=:id_sector)", nativeQuery = true)
	List<Predio> listaPrediosConPlanesAsignados(@Param("id_sector") int idSector);

}
