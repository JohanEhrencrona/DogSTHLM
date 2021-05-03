package com.example.accessingdatamysql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@RestController	// This means that this class is a Controller
@RequestMapping(path="/server") // This means URL's start with /demo (after Application path)
public class MainController {
	@Autowired // This means to get the bean called userRepository
			   // Which is auto-generated by Spring, we will use it to handle the data
	private UserRepository userRepository;
	@Autowired
	private TrashCanRepository trashCanRepository;

	@PostMapping(path="user/add") // Map ONLY POST Requests
	public @ResponseBody String addNewUser (@RequestParam String name
			, @RequestParam String email) {
		// @ResponseBody means the returned String is the response, not a view name
		// @RequestParam means it is a parameter from the GET or POST request

		User n = new User();
		n.setName(name);
		n.setEmail(email);
		userRepository.save(n);
		return "Saved";
	}

	@PostMapping(path="trashcan/add") // Map ONLY POST Requests
	public @ResponseBody String addNewTrashCan (@RequestParam double xCoordinate
			, @RequestParam double yCoordinate) {
		// @ResponseBody means the returned String is the response, not a view name
		// @RequestParam means it is a parameter from the GET or POST request

		TrashCan n = new TrashCan();
		n.setxCoordinate(xCoordinate);
		n.setyCoordinate(yCoordinate);
		trashCanRepository.save(n);
		return "Saved";
	}

	@GetMapping(path="/hello")
	public @ResponseBody void doGet(HttpServletRequest request,
							   HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		out.print("<h1>Hello</h1>");

		out.close();
	}

	@GetMapping(path="trashcan/all")
	public @ResponseBody Iterable<TrashCan> getAllTrashCans() {
		// This returns a JSON or XML with the users
		return trashCanRepository.findAll();
	}
}
