package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.app.proyectotitulo.domain.Sector;

@Repository
public interface SectorRepository extends JpaRepository<Sector, Integer> {

	List<Sector> findBySectorEliminadoOrderByNombreAsc(boolean sectorEliminado);

	Sector findByIdSector(int idSector);

	@Query(value = "select superficie from Sector where id_sector=?", nativeQuery = true)
	Integer TotalSuperSector(int id_sector);

	@Query(value = "SELECT distinct s.id_sector, s.nombre, s.superficie, s.sector_eliminado FROM Predio p join Sector s on p.id_sector=s.id_sector WHERE p.id_predio IN (SELECT ar.id_predio FROM Actividad_Realizada ar JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE t.id_temporada =:id_temporada AND t.temporada_eliminada=0 AND p.id_predio = ar.id_predio) AND p.predio_eliminado =0 and s.sector_eliminado=0", nativeQuery = true)
	List<Sector> listaSectoresConPrediosConPlanAsignado(@Param("id_temporada") int id_temporada);

	@Query(value = "select distinct s.id_sector, s.nombre, s.superficie, s.sector_eliminado from Actividad_Realizada ar join Predio p on ar.id_predio=p.id_predio join Temporada t on ar.id_temporada=t.id_temporada join Sector s on p.id_sector=s.id_sector where t.id_temporada=:id_temporada and s.sector_eliminado=0", nativeQuery = true)
	List<Sector> listaDeSectoresParaCostos(@Param("id_temporada") int id_temporada);

}
