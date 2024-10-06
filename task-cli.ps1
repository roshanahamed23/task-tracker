
function task-cli {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Action,

        [Parameter(Position = 1)]
        $Place,

        [Parameter(Position = 2)]
        [string]$Des
    )

    $path = "$pwd/tasks.json"
    $evalpath = Test-Path $path

    switch ($Action) {
      
        "add" {
            if ($evalpath -eq $false) {
                New-item -Path $PWD -Name "tasks.json" -ItemType File
                $Jsonformat = @{
                    tasks = @()
                }
                $data1 = [pscustomobject]@{
                    id          = $Jsonformat.tasks.length + 1
                    description = $Place
                    status      = "todo"
                    createdAt   = (Get-Date).ToString("o")
                    updatedAt   = (Get-Date).ToString("o")
                } 
                $Jsonformat.tasks += $data1
                $Jsonformat | ConvertTo-Json | Set-Content -Path $path
                Write-Host "Task added successfully (ID: $($data1.id))"
            }
            else {
                $obj = get-content -Path $path | ConvertFrom-Json
                $data2 = [pscustomobject]@{
                    id          = $obj.tasks.length + 1
                    description = $Place
                    status      = "todo"
                    createdAt   = (Get-Date).ToString("o")
                    updatedAt   = (Get-Date).ToString("o")
                }
                $obj.tasks += $data2
                $obj | ConvertTo-Json | Set-Content -Path $path 
                Write-Host "Task added successfully (ID: $($data2.id))"
            }
        }

        "update" {
            if ($evalpath -eq $true) {
                $obj = get-content -Path $path | ConvertFrom-Json
                $obj.tasks | ForEach-Object { if ($_.id -eq $Place) { $_.description = $Des } }
                $obj | ConvertTo-Json | set-content $path
                write-host "updated successfully on id:$($Place)"
            }
            else {
                write-host "does not have json file in the current path"
            }
        }

        "delete" {
            $obj=get-content $path | ConvertFrom-Json
            $obj.tasks = $obj.tasks | Where-Object {$_.id -ne $Place}
            $obj | ConvertTo-Json | Set-Content $Path 
            write-host "deleted successfully id:$($Place)"
        }

        "mark-in-progress" {
            if ($evalpath -eq $true) {
                $obj = get-content -Path $path | ConvertFrom-Json
                $obj.tasks | ForEach-Object { if ($_.id -eq $Place) { $_.status = "progress" } }
                $obj | ConvertTo-Json | set-content $path
                write-host "marked in-progress successfully on id:$($Place)"
            }
            else {
                write-host "does not have json file in the current path"
            }

        }

        "mark-done" {
            if ($evalpath -eq $true) {
                $obj = get-content -Path $path | ConvertFrom-Json
                $obj.tasks | ForEach-Object { if ($_.id -eq $Place) { $_.status = "done" } }
                $obj | ConvertTo-Json | set-content $path
                write-host "marked done successfully on id:$($Place)"
            }
            else {
                write-host "does not have json file in the current path"
            }
        }

        "list" {
            $obj=get-content $path | ConvertFrom-Json
            switch ($Place) {

                "" {
                    
                    $obj.tasks | Select-Object id,description,status | Format-Table
                }

                "done" { 
                    
                    $doneTasks = $obj.tasks | Where-Object { $_.status -eq $Place }
                    if ($doneTasks) {
                        $doneTasks | ForEach-Object -Process { 
                            Write-Host "$($_.id).$($_.description) - $($_.status)" 
                        }
                    } else {
                        Write-Host "No tasks marked as done."
                    }
                }

                "todo" {
                    
                    $todoTasks = $obj.tasks | Where-Object { $_.status -eq $Place }
                    if ($todoTasks) {
                        $todoTasks | ForEach-Object -Process { 
                            Write-Host "$($_.id).$($_.description) - $($_.status)" 
                        }
                    } else {
                        Write-Host "No tasks marked as todo."
                    }

                }

                "in-progress" {

                    $progressTasks = $obj.tasks | Where-Object { $_.status -eq "progress" }
                    if ($progressTasks) {
                        $progressTasks | ForEach-Object -Process { 
                            Write-Host "$($_.id).$($_.description) - $($_.status)" 
                        }
                    } else {
                        Write-Host "No tasks marked as in-Progress."
                    }

                }

                Default {
                     write-host "invaid command - check the command"
                }
                 
            }

        }

        Default {
            Write-Host "Sorry, I don't know what to do with $Action"
        }
        
    }
}