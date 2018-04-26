package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Insumo;

@Repository
public interface InsumoRepository extends JpaRepository<Insumo, Integer> {
	
	List<Insumo> findByInsumoEliminado(boolean insumoEliminado);//FindAll insumos que no están eliminados
	

}
