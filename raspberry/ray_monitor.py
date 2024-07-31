import time
import ray
from rich.console import Console
from rich.table import Table

def main():
    # Ray kümesine bağlan
    ray.init(address='auto')
    
    console = Console()
    
    while True:
        console.clear()
        
        # Mevcut tüm düğümlerin durumunu ve kaynak kullanımını al
        nodes = ray.nodes()
        
        table = Table(title="Ray Cluster Nodes Status")
        table.add_column("Node ID", justify="center", style="cyan", no_wrap=True)
        table.add_column("Status", justify="center", style="magenta")
        table.add_column("CPU Usage", justify="center", style="green")
        table.add_column("Memory Usage", justify="center", style="yellow")
        
        for node in nodes:
            node_id = node['NodeID']
            node_status = "Alive" if node['Alive'] else "Dead"
            cpu_usage = f"{node['Resources'].get('CPU', 0)}"
            memory_usage = f"{node['Resources'].get('memory', 0)}"
            
            table.add_row(node_id, node_status, cpu_usage, memory_usage)
        
        console.print(table)
        
        # 5 saniye bekle ve verileri güncelle
        time.sleep(5)

if __name__ == "__main__":
    main()
