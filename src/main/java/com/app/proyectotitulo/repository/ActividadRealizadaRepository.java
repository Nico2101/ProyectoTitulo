package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Realizada;

@Repository
public interface ActividadRealizadaRepository extends JpaRepository<Actividad_Realizada, Integer> {

	@Query(value = "select * from Actividad_Realizada ar join Temporada t on ar.id_temporada=t.id_temporada where t.estado=1 and t.temporada_eliminada=0 and ar.id_predio=:id_predio", nativeQuery = true)
	List<Actividad_Realizada> listaActividadesAsiganadasAlPredio(@Param("id_predio") int idPredio);

	Actividad_Realizada findByIdActividadRealizada(int idActividadRealizada);

	@Query(value = "select * from Actividad_Realizada ar join Temporada t on ar.id_temporada=t.id_temporada where t.id_temporada=:id_temporada and t.temporada_eliminada=0 and ar.id_predio=:id_predio", nativeQuery = true)
	List<Actividad_Realizada> actividadesAsignadasAPredioEnTemporada(@Param("id_temporada") int idTemporada,
			@Param("id_predio") int idPredio);

	@Query(value = "select ar.id_actividad_realizada, ar.fecha_estimada, ar.fecha_ejecucion_real,ar.cantidad_cosechada, ar.id_actividad, ar.id_temporada, ar.id_predio from Actividad_Realizada ar join Actividad a on ar.id_actividad=a.id_actividad join Plan_Ejecucion pe on a.id_plan_ejecucion=pe.id_plan_ejecucion join Temporada t on ar.id_temporada=t.id_temporada join Predio p on ar.id_predio=p.id_predio join Sector s on p.id_sector=s.id_sector where a.actividad_cosecha=1 and t.id_temporada=:id_temporada", nativeQuery = true)
	List<Actividad_Realizada> actividadesReporteTemporada(@Param("id_temporada") int idTemporada);
}
