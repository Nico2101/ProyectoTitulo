package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.domain.Temporada;

@Repository
public interface PredioRepository extends JpaRepository<Predio, Integer> {

	List<Predio> findByPredioEliminadoAndSectorSectorEliminadoOrderByNombreAsc(boolean predioEliminado,
			boolean sectorEliminado);// FindAll predio que no están
	// eliminados

	Predio findByIdPredio(int idPredio);

	@Query(value = "select sum(superficie) as totalSuperficie from Predio p where id_sector=? and predio_Eliminado='0'", nativeQuery = true)
	Integer superficieTotal(int id_sector);

	@Query(value = "SELECT p.id_predio,p.nombre,p.superficie,p.id_sector,p.estado,p.predio_eliminado FROM Predio p join Sector s on p.id_sector=s.id_sector WHERE p.id_predio not IN (SELECT ar.id_predio FROM Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE t.estado =1 AND t.temporada_eliminada=0 AND p.id_predio = ar.id_predio) and s.id_sector=?  AND p.predio_eliminado =0", nativeQuery = true)
	List<Predio> prediosDeUnSector(int idSector);

	@Query(value = "SELECT * FROM Predio p WHERE p.id_sector=? and p.predio_eliminado=0", nativeQuery = true)
	List<Predio> obtenerEstadoPredios(int idSector);

	// @Query(value = "select * from Predio p where id_sector=? and
	// predio_Eliminado='0'", nativeQuery = true)

	@Query(value = "SELECT p.id_predio,p.nombre,p.superficie,p.id_sector,p.estado,p.predio_eliminado FROM Predio p join Sector s on p.id_sector=s.id_sector WHERE p.id_predio IN (SELECT ar.id_predio FROM Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE t.estado =1 AND t.temporada_eliminada=0 AND p.id_predio = ar.id_predio ) and s.id_sector=:id_sector  AND p.predio_eliminado =0", nativeQuery = true)
	List<Predio> listaPrediosConPlanesAsignados(@Param("id_sector") int idSector);

	@Query(value = "SELECT p.id_predio,p.nombre,p.superficie,p.id_sector,p.estado,p.predio_eliminado FROM Predio p join Sector s on p.id_sector=s.id_sector WHERE p.id_predio IN (SELECT ar.id_predio FROM Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE t.id_temporada =:id_temporada AND t.temporada_eliminada=0 AND p.id_predio = ar.id_predio) and s.id_sector=:id_sector AND p.predio_eliminado =0", nativeQuery = true)
	List<Predio> listaPrediosConPlanesAsigandosParaComparacion(@Param("id_temporada") int idTemporada,
			@Param("id_sector") int idSector);

	@Query(value = "SELECT count(*) totalPredios from Predio where predio_eliminado=0", nativeQuery = true)
	Integer totalPredios();

	@Query(value = "select count(*) as prediosEnProceso from Predio p where p.id_predio in (select ar.id_predio from Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada where t.estado=1) and p.estado=\"En Proceso\" and p.predio_eliminado=0", nativeQuery = true)
	Integer totalPrediosEnProceso();

	@Query(value = "select count(*) as prediosCosechados from Predio p where p.id_predio in (select ar.id_predio from Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada where t.estado=1) and p.estado=\"Cosechado\" and p.predio_eliminado=0", nativeQuery = true)
	Integer totalPrediosCosechados();

	@Query(value = "select count(*) as prediosSinPlanAsignado from Predio where estado is null and predio_eliminado=0", nativeQuery = true)
	Integer totalPrediosSinPlanAsignado();

	@Query(value = "select distinct p.id_predio, p.nombre, p.superficie, p.predio_eliminado, p.estado, p.id_sector from Actividad_Realizada ar join Predio p on ar.id_predio=p.id_predio join Temporada t on ar.id_temporada=t.id_temporada join Sector s on p.id_sector=s.id_sector where t.id_temporada=:id_temporada and s.sector_eliminado=0 and p.predio_eliminado=0 and s.id_sector=:id_sector", nativeQuery = true)
	List<Predio> listaDePrediosParaCostos(@Param("id_temporada") int id_temporada, @Param("id_sector") int id_sector);

	List<Predio> findByNombre(String nombre);
}
