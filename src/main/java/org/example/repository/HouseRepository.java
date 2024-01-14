package org.example.repository;

import org.example.model.House;
import org.example.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HouseRepository extends JpaRepository<House, Long> {

    List<House> findByOwnersContains(Person owner);
}
