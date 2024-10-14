//
//  ListProjectsTableViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 06/10/24.
//


import UIKit

class ListProjectsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectTableView: UITableView!
    

    var projects = [Project]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                self.projects = try await Project.fetchProjects()
                projectTableView.reloadData()
                print(projects)
            }
            catch {
                print("Error: \(error)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCell
        let currentArticle = projects[indexPath.row]
        
        cell.configure(title: currentArticle.title, description: currentArticle.details.description, imageUrl: currentArticle.projectBanner, project_id: currentArticle.projectID, reports: currentArticle.reports, participants: currentArticle.participants, location:currentArticle.location)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailedProject" {
            let nextView = segue.destination as! DetailedProjectViewController
            let index = projectTableView.indexPathForSelectedRow?.row
            guard let index = index else {
                return
            }
            let project = projects[index]
            nextView.project = project
        }else if segue.identifier == "createProject" {
            print("Segue to Create Project is triggered")
            let nextVC = segue.destination as! CreateProjectViewController
            
        }
    }


 



}

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var projectImageView: UIImageView!
    
    @IBOutlet weak var projectIDView: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var projectTitleLabel: UILabel!
    
    @IBOutlet weak var projectLocationLabel: UILabel!
    @IBOutlet weak var projectReportsLabel: UILabel!
    
    @IBOutlet weak var projectParticipantsLabel: UILabel!
    
    func configure(title: String, description: String, imageUrl: String, project_id: String, reports: Int, participants: Int, location:String) {
        projectTitleLabel.text = title
        projectLocationLabel.text = location
        projectDescriptionLabel.text = description
        projectIDView.text = project_id
        projectImageView.image = UIImage(named: imageUrl)
        projectReportsLabel.text = "\(reports) Reports"
        projectParticipantsLabel.text = "\(participants) Participants"
        
        projectView.layer.cornerRadius = 20
        projectImageView.layer.cornerRadius = 20
    }
    
}

